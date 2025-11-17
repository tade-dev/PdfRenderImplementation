//
//  PDFPreviewSheet.swift
//  PdfRenderImplementation
//
//  Created by BSTAR on 17/11/2025.
//

import SwiftUI
import PDFKit

struct PDFPreviewSheet: View {
    let document: PDFDocument
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            PDFViewer(document: document)
                .navigationTitle("Preview PDF")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Close") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            savePDF(document)
                        }
                    }
                }
        }
    }
    
    func savePDF(_ doc: PDFDocument) {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("export.pdf")
        
        doc.write(to: url)
        
        // Share sheet UI
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?
            .rootViewController?
            .present(av, animated: true)
    }
}
