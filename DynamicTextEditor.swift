import SwiftUI

struct DynamicTextEditor: View {
    
    @State private var editingText = ""
    var placeholder = "Enter text here..."
    var miinHeight: CGFloat = 40
    var maaxHeight: CGFloat = 200
    var textFont: Font = .body
    
    @State private var textHeight: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            backendTextLabel
            
            TextEditor(text: $editingText)
                .font(textFont)
                .frame(height: min(max(textHeight, miinHeight), maaxHeight))
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) {
                    placeholderLabel
                }
        }
    }
    
    @ViewBuilder
    var backendTextLabel: some SwiftUI.View {
        Text(editingText)
            .font(textFont)
            .padding(.horizontal, 4)
            .padding(.vertical, 12)
            .background(
                GeometryReader { geometry in
                    Color.clear.onAppear {
                        textHeight = geometry.size.height
                    }
                    .onChange(of: editingText) { _ in
                        textHeight = geometry.size.height
                    }
                }
            )
            .opacity(0)
            .allowsHitTesting(false)
    }
    
    @ViewBuilder
    var placeholderLabel: some SwiftUI.View {
        Text(placeholder)
            .font(textFont)
            .foregroundColor(Color.gray.opacity(0.5))
            .padding(.leading, 4)
            .padding(.top, 8)
            .allowsHitTesting(false)
            .opacity(editingText.isEmpty ? 1.0 : 0)
    }
    
    
}

#Preview {
    DynamicTextEditor()
        .background(Color.gray.opacity(0.1))
        .padding()
}
