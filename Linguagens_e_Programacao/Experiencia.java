import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Experiencia implements Serializable {
    private static final long serialVersionUID = 1L;
    private String nome;
    private String data;
    private String descricao;
    private List<Equipamento> equipamentos;
    private List<Medicao> medicoes;
    private List<Investigador> investigadores;

    public Experiencia(String nome, String data, String descricao) {
        this.nome = nome;
        this.data = data;
        this.descricao = descricao;
        this.equipamentos = new ArrayList<>();
        this.medicoes = new ArrayList<>();
        this.investigadores = new ArrayList<>();
    }
    
        public void adicionarEquipamento(Equipamento equipamento) {
        equipamentos.add(equipamento);
    }

    public void adicionarMedicao(Medicao medicao) {
        medicoes.add(medicao);
    }

    public void adicionarInvestigador(Investigador investigador) {
        investigadores.add(investigador);
    }

    public String getNome() {
        return nome;
    }

    public String getData() {
        return data;
    }

    public String getDescricao() {
        return descricao;
    }

    public List<Medicao> getMedicoes() {
        return medicoes;
    }

    public List<Investigador> getInvestigadores() {
        return investigadores;
    }

    @Override
    public String toString() {
        return "Experiencia{" +
                "nome='" + nome + '\'' +
                ", data='" + data + '\'' +
                ", descricao='" + descricao + '\'' +
                ", medicoes=" + medicoes +
                ", investigadores=" + investigadores +
                '}';
    }
}
