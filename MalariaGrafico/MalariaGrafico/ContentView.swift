import SwiftUI

struct ContentView: View {
    // Anos para o eixo X do gráfico
    let years = ["2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"]
    
    // Categorias para a legenda
    let categories = ["Área Indígena", "Assentamento", "Garimpo", "Rural", "Urbana", "Total geral"]
    
    // Cores para cada categoria do gráfico
    let colors: [Color] = [
        Color.yellow,      // Área Indígena
        Color.red,         // Assentamento
        Color.blue,        // Garimpo
        Color.green,       // Rural
        Color.purple,      // Urbana
        Color.gray         // Total geral
    ]
    
    // Valor máximo para o eixo y (escala do gráfico)
    let maxYValue: CGFloat = 200000
    
    // Dados de casos de malária por categoria e ano (2013-2023)
    // Cada array representa os valores anuais para uma categoria específica
    let areaIndigenaData: [CGFloat] = [25000, 22000, 24000, 22000, 30000, 35000, 40000, 48000, 40000, 45000, 55000]
    let assentamentoData: [CGFloat] = [12000, 10000, 8000, 7000, 10000, 12000, 10000, 9000, 8000, 7000, 8000]
    let garimpoData: [CGFloat] = [10000, 6000, 5000, 5000, 6000, 5000, 7000, 15000, 20000, 22000, 20000]
    let ruralData: [CGFloat] = [83000, 75000, 72000, 65000, 110000, 110000, 80000, 60000, 50000, 45000, 45000]
    let urbanaData: [CGFloat] = [30000, 23000, 25000, 20000, 30000, 25000, 15000, 12000, 10000, 8000, 8000]
    let totalGeralData: [CGFloat] = [170000, 140000, 138000, 120000, 185000, 185000, 152000, 145000, 138000, 127000, 140000]
    
    var body: some View {
        ZStack {
            // Fundo dividido em duas cores
            VStack {
                Color.azulCinza.edgesIgnoringSafeArea(.all)
                Color.white.edgesIgnoringSafeArea(.bottom)
            }
            
            ScrollView {
                VStack {
                    // Cabeçalho com título e círculo decorativo
                    ZStack {
                        Text("ProtozoAIro")
                            .font(.system(size: 34, weight: .regular, design: .monospaced))
                            .font(.title)
                            .bold()
                            .padding()
                            .offset(y: -50)
                        
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 210, height: 210)
                            .offset(y: 120)
                    }
                    .frame(height: 200)
                    
                    VStack(alignment: .leading) {
                        
                        // Título do gráfico
                        Text("Casos de Malária por Categoria (2013-2023")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                            .multilineTextAlignment(.center)
                        
                        // Área principal do gráfico
                        GeometryReader { geometry in
                            ZStack {
                                gridLines        // Linhas de grade horizontais
                                yAxisLabels      // Rótulos do eixo Y
                                chartArea        // Linhas e pontos do gráfico
                                xAxisLabels(width: geometry.size.width)  // Rótulos do eixo X
                            }
                            .frame(height: 400)
                            .padding(.top, 40)
                            .padding(.bottom, 80)
                            .padding(.leading, 60)
                            .padding(.trailing, 10)
                        }
                        .frame(minHeight: 500)
                        
                        // Legenda do gráfico
                        legendView
                            .padding(.top, 30)
                        
                        // Nota de rodapé com fonte dos dados
                        Text("Fonte: Sivep-Malária/SVSA/MS. Excluídas as áreas não classificadas. Dados atualizados em 16/7/2024. Excluídas as LVC positivas. *Os dados de 2023 são preliminares, estando sujeitos a alterações.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                }
            }
        }
    }
    
    // Linhas de grade horizontais do gráfico
    private var gridLines: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<5) { i in
                Divider()
                    .background(Color.gray.opacity(0.3))
                Spacer()
            }
            Divider()
                .background(Color.gray.opacity(0.3))
        }
    }
    
    // Rótulos do eixo Y (valores numéricos)
    private var yAxisLabels: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing, spacing: 0) {
                ForEach(0..<6) { i in
                    let value = Int(Double(maxYValue) / 5.0 * Double(5 - i))
                    Text("\(formatNumber(value))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 60, alignment: .trailing)
                        .position(
                            x: -50,
                            y: CGFloat(i) * (geometry.size.height / 30)
                        )
                }
            }
        }
    }
    
    // Função para formatar números grandes (ex: 50000 -> 50k)
    private func formatNumber(_ number: Int) -> String {
        if number >= 1000 {
            return "\(number/1000)k"
        }
        return "\(number)"
    }
    
    // Área principal do gráfico com linhas e pontos para cada categoria
    private var chartArea: some View {
        GeometryReader { geometry in
            ZStack {
                // Desenha as linhas para cada categoria
                Group {
                    linePath(data: areaIndigenaData, geometry: geometry)
                        .stroke(colors[0], lineWidth: 3)
                    
                    linePath(data: assentamentoData, geometry: geometry)
                        .stroke(colors[1], lineWidth: 3)
                    
                    linePath(data: garimpoData, geometry: geometry)
                        .stroke(colors[2], lineWidth: 3)
                    
                    linePath(data: ruralData, geometry: geometry)
                        .stroke(colors[3], lineWidth: 3)
                    
                    linePath(data: urbanaData, geometry: geometry)
                        .stroke(colors[4], lineWidth: 3)
                    
                    // Linha tracejada para o total geral
                    linePath(data: totalGeralData, geometry: geometry)
                        .stroke(colors[5], style: StrokeStyle(lineWidth: 3, dash: [5, 5]))
                }
                
                // Adiciona pontos em cada valor para melhorar visualização
                ForEach(0..<years.count, id: \.self) { i in
                    Group {
                        Circle()
                            .fill(colors[0])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: areaIndigenaData, in: geometry))
                        
                        Circle()
                            .fill(colors[1])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: assentamentoData, in: geometry))
                        
                        Circle()
                            .fill(colors[2])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: garimpoData, in: geometry))
                        
                        Circle()
                            .fill(colors[3])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: ruralData, in: geometry))
                        
                        Circle()
                            .fill(colors[4])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: urbanaData, in: geometry))
                        
                        Circle()
                            .fill(colors[5])
                            .frame(width: 8, height: 8)
                            .position(pointPosition(for: i, data: totalGeralData, in: geometry))
                    }
                }
            }
        }
    }
    
    // Calcula a posição de cada ponto no gráfico
    private func pointPosition(for index: Int, data: [CGFloat], in geometry: GeometryProxy) -> CGPoint {
        let width = geometry.size.width
        let height = geometry.size.height
        
        let xScale = width / CGFloat(data.count - 1)
        let yScale = height / maxYValue
        
        return CGPoint(
            x: CGFloat(index) * xScale,
            y: height - data[index] * yScale
        )
    }
    
    // Cria o caminho para desenhar as linhas do gráfico
    private func linePath(data: [CGFloat], geometry: GeometryProxy) -> Path {
        Path { path in
            let width = geometry.size.width
            let height = geometry.size.height
            
            let xScale = width / CGFloat(data.count - 1)
            let yScale = height / maxYValue
            
            let startPoint = CGPoint(
                x: 0,
                y: height - data[0] * yScale
            )
            path.move(to: startPoint)
            
            for i in 1..<data.count {
                let point = CGPoint(
                    x: CGFloat(i) * xScale,
                    y: height - data[i] * yScale
                )
                path.addLine(to: point)
            }
        }
    }
    
    // Rótulos do eixo X (anos)
    private func xAxisLabels(width: CGFloat) -> some View {
        GeometryReader { geometry in
            // Mostra todos os rótulos em telas largas, ou apenas anos pares em telas estreitas
            let showAllLabels = geometry.size.width > 400
            
            ZStack {
                ForEach(0..<years.count, id: \.self) { i in
                    if showAllLabels || i % 2 == 0 {
                        Text(years[i])
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .rotationEffect(.degrees(-45))
                            .position(
                                x: CGFloat(i) * (geometry.size.width / CGFloat(years.count - 1)),
                                y: geometry.size.height - 20
                            )
                    }
                }
            }
        }
        .frame(height: 60)
        .offset(y: 230)
    }
    
    // Legenda adaptativa que muda layout conforme tamanho da tela
    private var legendView: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > 500
            
            if isWide {
                // Layout horizontal para telas largas
                HStack(spacing: 12) {
                    ForEach(0..<categories.count, id: \.self) { i in
                        legendItem(for: i)
                    }
                }
                .padding(.horizontal)
            } else {
                // Layout em coluna para telas estreitas
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(0..<categories.count, id: \.self) { i in
                        legendItem(for: i)
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 100)
    }
    
    // Item individual da legenda
    private func legendItem(for index: Int) -> some View {
        HStack(spacing: 5) {
            if index == categories.count - 1 {
                // Item tracejado para o Total geral
                Rectangle()
                    .fill(colors[index])
                    .frame(width: 20, height: 3)
                    .overlay(
                        Rectangle()
                            .stroke(Color.white, lineWidth: 1)
                            .frame(width: 20, height: 3)
                            .dash(lengths: [2, 2])
                    )
            } else {
                // Item normal para as outras categorias
                Rectangle()
                    .fill(colors[index])
                    .frame(width: 20, height: 3)
            }
            
            Text(categories[index])
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// Extensão para criar linhas tracejadas
extension View {
    func dash(lengths: [CGFloat] = [5, 5]) -> some View {
        self.overlay(
            GeometryReader { geometry in
                Path { path in
                    var x: CGFloat = 0
                    
                    while x < geometry.size.width {
                        for length in lengths {
                            if x + length > geometry.size.width {
                                break
                            }
                            
                            path.move(to: CGPoint(x: x, y: geometry.size.height / 2))
                            x += length
                            path.addLine(to: CGPoint(x: x, y: geometry.size.height / 2))
                        }
                    }
                }
                .stroke(Color.clear)
            }
        )
    }
}

#Preview {
    ContentView()
}
