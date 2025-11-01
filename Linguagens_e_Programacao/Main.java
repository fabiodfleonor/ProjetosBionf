import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        SistemaGestao sistema;
        
        try {
            sistema = SistemaGestao.carregarDados("sistema_gestao.dat");
            System.out.println("Dados carregados com sucesso.");
        } catch (IOException | ClassNotFoundException e) {
            sistema = new SistemaGestao();
            System.out.println("Erro ao carregar os dados. Iniciando novo sistema.");
        }
        new Menu(sistema).exibirMenu();
    }
}
