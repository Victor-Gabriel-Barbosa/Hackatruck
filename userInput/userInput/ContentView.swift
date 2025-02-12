import SwiftUI

struct ContentView: View {
    
    @State private var distancia: Double = 0.0;
    @State private var tempo: Double = 0.0;
    @State private var imagem: String = "luckyblock";
    @State private var kmH: Double = 0.0;
    @State private var fundo: Color = .gray
    @State private var mostrar: Bool = false
    
    func calcularVelocidade(distancia: Double, tempo: Double) -> Double {
        if tempo != 0 {
            return distancia / tempo
        } else {
            return 0
        }
    }

    func imagemBaseadaNaVelocidade(kmH: Double) -> String {
        switch kmH {
        case 0 ..< 9.9:
            fundo = .verdeClaro
            return "tartaruga"
            
        case 10 ..< 29.9:
            fundo = .azulClaro
            return "elefante"
            
        case 30 ..< 69.9:
            fundo = .laranjaClaro
            return "avestruz"
            
        case 70 ..< 89.9:
            fundo = .amareloClaro
            return "leao"
            
        case 90 ..< 130:
            fundo = .vermelhoClaro
            return "guepardo"
            
        default:
            return "luckyblock"
        }
    }

    var body: some View {
        ZStack{
            fundo.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Digite a distância (km):")
                TextField("", value: $distancia, format: .number, prompt: Text("0").foregroundColor(.black)).background(Color.white).multilineTextAlignment(.center).cornerRadius(10).frame(width: 200, height: 30).keyboardType(.decimalPad).textContentType(.oneTimeCode)
                Text("Digite o tempo (h):")
                TextField("", value: $tempo, format: .number, prompt: Text("0").foregroundColor(.black)).background(Color.white).multilineTextAlignment(.center).cornerRadius(10).frame(width: 200, height: 30).keyboardType(.decimalPad).textContentType(.oneTimeCode)
                Button(action: {
                    kmH = calcularVelocidade(distancia: distancia, tempo: tempo)
                    imagem = imagemBaseadaNaVelocidade(kmH: kmH)
                }, label: {
                    Text("Calcular").foregroundColor(.orange)
                }).background(Color.black)
                    .buttonStyle(.bordered)
                .cornerRadius(10)
                Text("\(kmH, specifier: "%.2f") km/h").font(.largeTitle)
                Image("\(imagem)").resizable().scaledToFit().clipShape(Circle()).frame(width: 300, height: 300).padding()
                VStack
                {
                    HStack
                    {
                        Text("TARTARUGA (0 - 9.9km/h)  ").font(.title3).foregroundStyle(.white)
                        Circle().fill(Color("verdeClaro")).frame(width: 20, height: 20)
                    }
                    HStack
                    {
                        Text("ELEFANTE (10 - 29.9km/h)  ").font(.title3).foregroundStyle(.white)
                        Circle().fill(Color("azulClaro")).frame(width: 20, height: 20)
                    }
                    
                    HStack
                    {
                        Text("AVESTRUZ (30 - 69.9km/h)").font(.title3).foregroundStyle(.white)
                        Circle().fill(Color("laranjaClaro")).frame(width: 20, height: 20)
                    }
                    
                    HStack
                    {
                        Text("LEÃO (70 - 89.9km/h)           ").font(.title3).foregroundStyle(.white)
                        Circle().fill(Color("amareloClaro")).frame(width: 20, height: 20)
                    }
                    
                    HStack
                    {
                        Text("GUEPARDO (90 - 130km/h) ").font(.title3).foregroundStyle(.white)
                        Circle().fill(Color("vermelhoClaro")).frame(width: 20, height: 20)
                    }
                    
                    
                }.padding(.horizontal, 20).padding(.vertical, 20).background(.black).cornerRadius(10)
                
                Spacer()
            }
            .padding(.top, 30)
        }
    }
}

#Preview {
    ContentView()
}
