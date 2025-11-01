import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.io.IOException;
public class Menu {
    private SistemaGestao sistema;

    public Menu(SistemaGestao sistema) {
        this.sistema = sistema;
    }

    public SistemaGestao getSistema() {
        return sistema;
    }

    public void exibirMenu() {
        Scanner scanner = new Scanner(System.in);
        int opcao;

        do {
            System.out.println("Menu:");
            System.out.println("0. Salvar Dados e Sair");
            System.out.println("1. Adicionar Investigador");
            System.out.println("2. Adicionar Equipamento");
            System.out.println("3. Adicionar Experiência");
            System.out.println("4. Pesquisar Investigador");
            System.out.println("5. Pesquisar Equipamento");
            System.out.println("6. Pesquisar Experiência");
            System.out.println("7. Gerar Relatório Detalhado sobre as Experiências");
            System.out.println("8. Sair");
            System.out.print("Escolha uma opção: ");
            opcao = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcao) {
                case 1:
                    adicionarInvestigador(scanner);
                    break;
                case 2:
                    adicionarEquipamento(scanner);
                    break;
                case 3:
                    adicionarExperiencia(scanner);
                    break;
                case 4:
                    pesquisarInvestigador(scanner);
                    break;
                case 5:
                    pesquisarEquipamento(scanner);
                    break;
                case 6:
                    pesquisarExperiencia(scanner);
                    break;
                case 7:
                    sistema.gerarRelatorioExperiencias();
                    break;
                case 8:
                    System.out.println("Saindo...");
                    break;
                default:
                    System.out.println("Opção inválida.");
            }
        } while (opcao != 8);

        scanner.close();
    }

    private void adicionarInvestigador(Scanner scanner) {
        System.out.print("Nome do Investigador: ");
        String nome = scanner.nextLine();
        System.out.print("Especialidade: ");
        String especialidade = scanner.nextLine();
        System.out.print("ID: ");
        String id = scanner.nextLine();
        Investigador investigador = new Investigador(nome, especialidade, id);
        sistema.adicionarInvestigador(investigador);
        System.out.println("Investigador adicionado com sucesso.");
    }

private void adicionarEquipamento(Scanner scanner) {
    System.out.print("Nome do Equipamento: ");
    String nome = scanner.nextLine();
    System.out.print("Tipo do Equipamento: ");
    String tipo = scanner.nextLine();
    System.out.print("Data da Última Calibração (yyyy-MM-dd): ");
    String data = scanner.nextLine();
    System.out.print("Está em funcionamento? (true/false): ");
    boolean emFuncionamento = scanner.nextBoolean();
    scanner.nextLine(); 

    Equipamento equipamento = new Equipamento(nome, tipo, data, emFuncionamento);
    
    System.out.print("Deseja associar este equipamento a alguma experiência? (sim/não): ");
    String resposta = scanner.nextLine();
    if (resposta.equalsIgnoreCase("sim")) {
        System.out.print("Digite o nome da Experiência a associar: ");
        String nomeExperiencia = scanner.nextLine();
        Experiencia experiencia = sistema.buscarExperienciaPorNome(nomeExperiencia);
        if (experiencia != null) {
            experiencia.adicionarEquipamento(equipamento);
            System.out.println("Equipamento associado à experiência com sucesso.");
        } else {
            System.out.println("Experiência não encontrada.");
        }
    }

    sistema.adicionarEquipamento(equipamento);
    System.out.println("Equipamento adicionado com sucesso.");
}

    private void adicionarExperiencia(Scanner scanner) {
        System.out.print("Nome da Experiência: ");
        String nome = scanner.nextLine();
        System.out.print("Data da Experiência (yyyy-MM-dd): ");
        String data = scanner.nextLine();
        System.out.print("Descrição: ");
        String descricao = scanner.nextLine();
        Experiencia experiencia = new Experiencia(nome, data, descricao);

        System.out.print("Quantas medições deseja adicionar? ");
        int numMedicoes = scanner.nextInt();
        scanner.nextLine(); 
        for (int i = 0; i < numMedicoes; i++) {
            System.out.print("Tipo da Medição: ");
            String tipoMedicao = scanner.nextLine();
            System.out.print("Valor Obtido: ");
            double valorObtido = scanner.nextDouble();
            scanner.nextLine(); 
            System.out.print("Data/Hora da Medição (yyyy-MM-dd HH:mm:ss): ");
            String dataHora = scanner.nextLine();
            Medicao medicao = new Medicao(tipoMedicao, valorObtido, dataHora);
            experiencia.adicionarMedicao(medicao);
        }

        System.out.print("Quantos investigadores deseja associar à experiência? ");
        int numInvestigadores = scanner.nextInt();
        scanner.nextLine(); 
        for (int i = 0; i < numInvestigadores; i++) {
            System.out.print("ID do Investigador: ");
            String idInvestigador = scanner.nextLine();
            Investigador investigador = sistema.pesquisarInvestigadorPorId(idInvestigador);
            if (investigador != null) {
                experiencia.adicionarInvestigador(investigador);
            } else {
                System.out.println("Investigador com o ID " + idInvestigador + " não encontrado.");
            }
        }

        sistema.adicionarExperiencia(experiencia);
        System.out.println("Experiência adicionada com sucesso.");
    }

    private void pesquisarInvestigador(Scanner scanner) {
        System.out.print("Digite o termo de pesquisa para o Investigador: ");
        String termo = scanner.nextLine();
        sistema.pesquisarInvestigador(termo);
    }

    private void pesquisarEquipamento(Scanner scanner) {
        System.out.print("Digite o termo de pesquisa para o Equipamento: ");
        String termo = scanner.nextLine();
        sistema.pesquisarEquipamento(termo);
    }

    private void pesquisarExperiencia(Scanner scanner) {
        System.out.print("Digite o termo de pesquisa para a Experiência: ");
        String termo = scanner.nextLine();
        for (Experiencia experiencia : sistema.getExperiencias()) {
            if (experiencia.getNome().toLowerCase().contains(termo.toLowerCase())) {
                System.out.println(experiencia);
            }
        }
    }
}
