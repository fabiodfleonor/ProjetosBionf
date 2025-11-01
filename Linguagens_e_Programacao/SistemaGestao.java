import java.io.*;
import java.util.*;

public class SistemaGestao implements Serializable {
    private static final long serialVersionUID = 1L;
    private List<Experiencia> experiencias;
    private List<Equipamento> equipamentos;
    private List<Investigador> investigadores;

    public SistemaGestao() {
        this.experiencias = new ArrayList<>();
        this.equipamentos = new ArrayList<>();
        this.investigadores = new ArrayList<>();
    }

    public void adicionarExperiencia(Experiencia experiencia) {
        experiencias.add(experiencia);
    }

    public void adicionarEquipamento(Equipamento equipamento) {
        equipamentos.add(equipamento);
    }

    public void adicionarInvestigador(Investigador investigador) {
        investigadores.add(investigador);
    }
    
    public Experiencia buscarExperienciaPorNome(String nome) {
    for (Experiencia experiencia : experiencias) {
        if (experiencia.getNome().equalsIgnoreCase(nome)) {
            return experiencia;
        }
    }
    return null; 
}

    public void pesquisarInvestigador(String termo) {
        for (Investigador investigador : investigadores) {
            if (investigador.getNome().toLowerCase().contains(termo.toLowerCase()) ||
                investigador.getEspecialidade().toLowerCase().contains(termo.toLowerCase())) {
                System.out.println(investigador);
            }
        }
    }

    public void pesquisarEquipamento(String termo) {
        for (Equipamento equipamento : equipamentos) {
            if ((equipamento.getNome() != null && equipamento.getNome().toLowerCase().contains(termo.toLowerCase())) ||
                (equipamento.getTipo() != null && equipamento.getTipo().toLowerCase().contains(termo.toLowerCase()))) {
                System.out.println(equipamento);
            }
        }
    }
    
    public Investigador pesquisarInvestigadorPorId(String id) {
    for (Investigador investigador : investigadores) {
        if (investigador.getId().equals(id)) {
            return investigador;
        }
    }
    return null; 
}


    public List<Experiencia> getExperiencias() {
        return experiencias;
    }

    public void salvarDados(String nomeArquivo) throws IOException {
        try (ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(nomeArquivo))) {
            out.writeObject(this);
        }
    }

    public static SistemaGestao carregarDados(String nomeArquivo) throws IOException, ClassNotFoundException {
        try (ObjectInputStream in = new ObjectInputStream(new FileInputStream(nomeArquivo))) {
            return (SistemaGestao) in.readObject();
        }
    }

    public void gerarRelatorioExperiencias() {
        if (experiencias.isEmpty()) {
            System.out.println("Nenhuma experiência encontrada.");
            return;
        }

        for (Experiencia experiencia : experiencias) {
            System.out.println("Relatório da Experiência: ");
            System.out.println("Nome: " + experiencia.getNome());
            System.out.println("Data: " + experiencia.getData());
            System.out.println("Descrição: " + experiencia.getDescricao());
            System.out.println("Medições:");
            for (Medicao medicao : experiencia.getMedicoes()) {
                System.out.println("\tTipo: " + medicao.getTipo() + ", Valor: " + medicao.getValorObtido() + ", Data/Hora: " + medicao.getDataHora());
            }

            System.out.println("Investigadores:");
            for (Investigador investigador : experiencia.getInvestigadores()) {
                System.out.println("\tNome: " + investigador.getNome() + ", Especialidade: " + investigador.getEspecialidade() + ", ID: " + investigador.getId());
            }

            System.out.println("--------------------------------------");
        }
    }
}
