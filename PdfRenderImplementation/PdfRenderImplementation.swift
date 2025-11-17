//
//  PdfRenderImplementation.swift
//  PdfRenderImplementation
//
//  Created by BSTAR on 17/11/2025.
//

import SwiftUI
import PDFKit

@MainActor
func renderMultipagePDFDocument<Content: View>(
    view: Content,
    pageSize: CGSize = CGSize(width: 612, height: 792)
) -> PDFDocument? {
    
    let pdfDocument = PDFDocument()
    
    let fullRenderer = ImageRenderer(content: view)
    guard let fullImage = fullRenderer.uiImage else { return nil }
    
    let totalHeight = fullImage.size.height
    let totalWidth = fullImage.size.width
    let pageHeight = pageSize.height
    let scale = pageSize.width / totalWidth
    
    let numPages = Int(ceil((totalHeight * scale) / pageHeight))
    
    for pageIndex in 0..<numPages {
        let renderer = UIGraphicsImageRenderer(size: pageSize)
        
        let img = renderer.image { ctx in
            ctx.cgContext.saveGState()
            
            let offsetY = -CGFloat(pageIndex) * pageHeight / scale
            ctx.cgContext.scaleBy(x: scale, y: scale)
            ctx.cgContext.translateBy(x: 0, y: offsetY)
            
            fullImage.draw(at: .zero)
            ctx.cgContext.restoreGState()
        }
        
        if let pdfPage = PDFPage(image: img) {
            pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
        }
    }
    
    return pdfDocument
}
