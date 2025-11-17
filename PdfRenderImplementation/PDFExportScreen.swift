//
//  PDFExportScreen.swift
//  PdfRenderImplementation
//
//  Created by BSTAR on 17/11/2025.
//

import SwiftUI
import PDFKit

struct PDFExportScreen: View {
    @State private var pdfDoc: PDFDocument?
    @State private var showSheet = false
    
    let sampleInvoice = InvoiceView(
        invoiceNumber: "INV-2025-001",
        invoiceDate: "16 Nov 2025",
        dueDate: "23 Nov 2025",
        customerName: "John Doe",
        customerAddress: "45 Example Road\nLondon, UK",
        items: [
            .init(description: "iPhone 15 Pro Max", quantity: 1, price: 1199.00),
            .init(description: "USB-C Charger", quantity: 2, price: 29.00),
            .init(description: "AppleCare+ (2 Years)", quantity: 1, price: 199.00),
            .init(description: "Shipping", quantity: 1, price: 15.00)
        ]
    )
    
    var body: some View {
        VStack {
            Button("Generate PDF") {
                if let doc = renderMultipagePDFDocument(view: sampleInvoice) {
                    self.pdfDoc = doc
                    self.showSheet = true
                }
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            if let doc = pdfDoc {
                PDFPreviewSheet(document: doc)
            }
        }
    }
}

#Preview {
    PDFExportScreen()
}
