//
//  PDFViewer.swift
//  PdfRenderImplementation
//
//  Created by BSTAR on 17/11/2025.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    let document: PDFDocument
    
    func makeUIView(context: Context) -> PDFView {
        let v = PDFView()
        v.document = document
        v.autoScales = true
        v.displayMode = .singlePageContinuous
        v.displayDirection = .vertical
        return v
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
