//
//  ContentView.swift
//  openaiplatform
//
//  Created by user234729 on 4/9/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var prompt: String = ""
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    TextField("Enter prompt", text: $prompt, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Generate"){
                        isLoading = true
                        Task{
                            do {
                                let response = try await DallEImageGenerator.shared.generateImage(withPrompt: prompt, apiKey: Secrets.apiKey)
                                
                                if let url = response.data.map(\.url).first{
                                    let (data, _) = try await URLSession.shared.data(from: url)
                                    image = UIImage(data: data)
                                    isLoading = false
                                }
                            } catch {
                                print(error)
                                isLoading = false
                                
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 256, height: 256)
                    } else {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 256, height: 256)
                            .overlay {
                                if isLoading {
                                    VStack {
                                        ProgressView()
                                        Text("Loading...")
                                    }
                                }
                            }
                    }
                }
                .padding()

                Spacer()

                NavigationLink(destination: SentenceCompletionView()) {
                    Text("Go to Sentence Completer")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()

                NavigationLink(destination: SentimentAnalysisView()) {
                    Text("Go to Sentiment Analysis")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
        }
    }
}

    
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






