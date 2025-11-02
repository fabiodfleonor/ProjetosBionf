# knn_model_humanizado.py
# Classificação com K-Nearest Neighbors utilizando distância de Manhattan

from sklearn.preprocessing import MinMaxScaler
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# -------------------------------
# Dados iniciais dos clientes
# -------------------------------
dados = pd.DataFrame({
    "Idade": [25, 35, 45, 30],
    "Renda": [50, 65, 85, 70],
    "Compras": [20, 40, 15, 30],
    "Classe": ["Baixo", "Médio", "Baixo", "Médio"]
}, index=["A", "B", "C", "D"])

# Novo cliente (E) a classificar
novo_cliente = pd.DataFrame({
    "Idade": [38],
    "Renda": [90],
    "Compras": [45]
}, index=["E"])

# -------------------------------
# Normalização com MinMaxScaler
# -------------------------------
scaler = MinMaxScaler()
X = scaler.fit_transform(dados[["Idade", "Renda", "Compras"]])
X_novo = scaler.transform(novo_cliente)

# -------------------------------
# Cálculo manual da distância de Manhattan
# -------------------------------
distancias = np.sum(np.abs(X - X_novo), axis=1)
indices_vizinhos = np.argsort(distancias)[:3]

# Extracção das classes dos 3 vizinhos mais próximos
vizinhos_classes = dados.iloc[indices_vizinhos]["Classe"].values
vizinhos_distancias = distancias[indices_vizinhos]

# -------------------------------
# Classificação com KNN da scikit-learn
# -------------------------------
knn = KNeighborsClassifier(n_neighbors=3, metric='manhattan')
knn.fit(X, dados["Classe"])
predicao = knn.predict(X_novo)

# -------------------------------
# Apresentação dos resultados
# -------------------------------
print("Classe prevista para o Cliente E:", predicao[0])
print("Vizinhos mais próximos:", vizinhos_classes)
print("Distâncias aos vizinhos:", vizinhos_distancias)


# kmeans_manual_humanizado.py
# 1ª Iteração do K-Means com distância de Manhattan

pontos = {"P1": (2, 3), "P2": (3, 3), "P3": (6, 5), "P4": (8, 8)}
C1 = np.array(pontos["P1"])  # Centróide inicial 1
C2 = np.array(pontos["P4"])  # Centróide inicial 2

def manhattan(p1, p2):
    return np.abs(p1[0] - p2[0]) + np.abs(p1[1] - p2[1])

# Atribuir pontos ao cluster mais próximo
clusters = {1: [], 2: []}
for nome, ponto in pontos.items():
    d1 = manhattan(ponto, C1)
    d2 = manhattan(ponto, C2)
    clusters[1 if d1 < d2 else 2].append(ponto)

def novo_centro(pontos_cluster):
    xs, ys = zip(*pontos_cluster)
    return (np.mean(xs), np.mean(ys))

print("Novo centróide C1:", novo_centro(clusters[1]))
print("Novo centróide C2:", novo_centro(clusters[2]))


# silhueta_humanizado.py
# Cálculo do coeficiente de silhueta com distância de Manhattan

cluster_1 = {"P1": (1, 1), "P2": (2, 1)}
cluster_2 = {"P3": (4, 4), "P4": (5, 4)}
todos = {**cluster_1, **cluster_2}

def manhattan(p1, p2):
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

def coesao(p, cluster):
    outros = [v for v in cluster.values() if v != p]
    return np.mean([manhattan(p, o) for o in outros]) if outros else 0

def separacao(p, outro_cluster):
    return np.mean([manhattan(p, o) for o in outro_cluster.values()])

silhuetas = {}
for nome, ponto in todos.items():
    if nome in cluster_1:
        a = coesao(ponto, cluster_1)
        b = separacao(ponto, cluster_2)
    else:
        a = coesao(ponto, cluster_2)
        b = separacao(ponto, cluster_1)
    s = (b - a) / max(a, b) if max(a, b) != 0 else 0
    silhuetas[nome] = round(s, 4)

print("Coeficientes de Silhueta por ponto:", silhuetas)
print("Média do coeficiente:", round(np.mean(list(silhuetas.values())), 4))


# Dados dos clientes
dados = pd.DataFrame({
    "Idade": [25, 35, 45, 30],
    "Renda": [50, 65, 85, 70],
    "Classe": ["Baixo", "Médio", "Baixo", "Médio"]
}, index=["A", "B", "C", "D"])

# Novo cliente
novo_cliente = pd.DataFrame({
    "Idade": [38],
    "Renda": [90],
    "Classe": ["Desconhecida"]  # só para facilitar estrutura
}, index=["E"])

# Combinar todos os dados para facilitar o plot
dados_completo = pd.concat([dados, novo_cliente])

# Cores e estilos
cores = {"Baixo": "blue", "Médio": "orange", "Desconhecida": "green"}
marcadores = {"Desconhecida": ("*", 200), "Baixo": ("o", 80), "Médio": ("o", 80)}

plt.figure(figsize=(10, 7))
for idx, linha in dados_completo.iterrows():
    cor = cores[linha["Classe"]]
    marker, size = marcadores[linha["Classe"]]
    plt.scatter(linha["Idade"], linha["Renda"], color=cor, s=size, marker=marker, label=linha["Classe"] if idx == "E" else "")
    plt.text(linha["Idade"] + 0.3, linha["Renda"] + 0.3, idx, fontsize=10)

# Evita duplicação de rótulo na legenda
handles = [
    plt.Line2D([0], [0], marker='o', color='w', label='Baixo', markerfacecolor='blue', markersize=10),
    plt.Line2D([0], [0], marker='o', color='w', label='Médio', markerfacecolor='orange', markersize=10),
    plt.Line2D([0], [0], marker='*', color='w', label='Novo Cliente', markerfacecolor='green', markersize=15)
]

plt.legend(handles=handles)
plt.title("Distribuição dos Clientes - KNN", fontsize=14)
plt.xlabel("Idade")
plt.ylabel("Renda Anual (mil €)")
plt.grid(True)
plt.tight_layout()
plt.show()