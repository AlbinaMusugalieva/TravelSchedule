import SwiftUI
import WebKit
import Combine

@MainActor struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Binding var isPresented: Bool
    
    @StateObject private var viewModel: UserAgreementViewModel
    
    init(url: URL, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: UserAgreementViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            WebViewContainer(url: viewModel.url)
                .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isPresented = false
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.ypBlack)
                }
            }
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
