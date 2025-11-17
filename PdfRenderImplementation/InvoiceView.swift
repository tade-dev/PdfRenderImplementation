//
//  InvoiceView.swift
//  PdfRenderImplementation
//
//  Created by BSTAR on 17/11/2025.
//

import SwiftUI

struct InvoiceView: View {
    let invoiceNumber: String
    let invoiceDate: String
    let dueDate: String
    
    let customerName: String
    let customerAddress: String
    
    struct Item: Identifiable {
        let id = UUID()
        let description: String
        let quantity: Int
        let price: Double
        
        var total: Double { Double(quantity) * price }
    }
    
    let items: [Item]
    
    var subtotal: Double {
        items.reduce(0) { $0 + $1.total }
    }
    
    var tax: Double { subtotal * 0.075 } // 7.5% tax
    var total: Double { subtotal + tax }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // MARK: - Header
            HStack {
                VStack(alignment: .leading) {
                    Text("YOUR COMPANY")
                        .font(.largeTitle.bold())
                    Text("123 Business Street\nCity, Country")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text("INVOICE")
                        .font(.largeTitle.bold())
                    Text("Invoice #: \(invoiceNumber)")
                    Text("Date: \(invoiceDate)")
                    Text("Due: \(dueDate)")
                }
                .font(.headline)
            }
            
            Divider()
            
            // MARK: - Bill To
            VStack(alignment: .leading, spacing: 8) {
                Text("BILL TO")
                    .font(.headline)
                Text(customerName)
                    .font(.title3.bold())
                Text(customerAddress)
            }
            
            // MARK: - Items Table
            VStack(spacing: 0) {
                HStack {
                    Text("Description").font(.headline)
                    Spacer()
                    Text("Qty").font(.headline)
                        .frame(width: 40)
                    Text("Price").font(.headline)
                        .frame(width: 80, alignment: .trailing)
                    Text("Total").font(.headline)
                        .frame(width: 80, alignment: .trailing)
                }
                .padding(.vertical, 8)
                
                Divider()
                
                ForEach(items) { item in
                    HStack(alignment: .top) {
                        Text(item.description)
                        Spacer()
                        Text("\(item.quantity)")
                            .frame(width: 40)
                        Text(String(format: "$%.2f", item.price))
                            .frame(width: 80, alignment: .trailing)
                        Text(String(format: "$%.2f", item.total))
                            .frame(width: 80, alignment: .trailing)
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
            }
            
            // MARK: - Totals
            VStack(alignment: .trailing, spacing: 6) {
                HStack {
                    Spacer()
                    Text("Subtotal:")
                    Text(String(format: "$%.2f", subtotal))
                        .frame(width: 120, alignment: .trailing)
                }
                
                HStack {
                    Spacer()
                    Text("Tax (7.5%):")
                    Text(String(format: "$%.2f", tax))
                        .frame(width: 120, alignment: .trailing)
                }
                
                HStack {
                    Spacer()
                    Text("Total:")
                        .font(.title3.bold())
                    Text(String(format: "$%.2f", total))
                        .font(.title3.bold())
                        .frame(width: 120, alignment: .trailing)
                }
            }
            .padding(.top)
            
            // MARK: - Notes
            VStack(alignment: .leading, spacing: 6) {
                Text("NOTES")
                    .font(.headline)
                Text("Thank you for your business. Please make payment before the due date.")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}
