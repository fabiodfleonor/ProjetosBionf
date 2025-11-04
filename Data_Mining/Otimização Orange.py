import pandas as pd

# 1. Carregar o arquivo mantendo TODAS as colunas
input_path = "c:/Users/Rodrigo/Downloads/ProjetoDM/DataSets/train_amostra.csv"
output_path = "c:/Users/Rodrigo/Downloads/ProjetoDM/DataSets/train_processed.csv"

df = pd.read_csv(input_path)

# 2. Converter 'target' para texto SEM PERDER metadados
df['target'] = (
    "category_" + df['target'].astype(str).str.upper().str.replace(" ", "_")
)

# 3. Garantir que outras colunas numéricas/datas não sejam perdidas
numeric_cols = ['abstract_id', 'line_number']  # Substitua pelas suas colunas numéricas
for col in numeric_cols:
    if col in df.columns:
        df[col] = df[col].astype(str)  # Converte para texto, mas preserva valores

# 4. Salvar arquivo processado
df.to_csv(output_path, index=False, encoding='utf-8')
print(f"Arquivo salvo em: {output_path}")
print("Colunas disponíveis:", list(df.columns))