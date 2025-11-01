import java.io.Serializable;

public class Investigador implements Serializable {
    private static final long serialVersionUID = 1L;
    private String nome;
    private String especialidade;
    private String id;

    public Investigador(String nome, String especialidade, String id) {
        this.nome = nome;
        this.especialidade = especialidade;
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public String getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Investigador{" +
                "nome='" + nome + '\'' +
                ", especialidade='" + especialidade + '\'' +
                ", id='" + id + '\'' +
                '}';
    }
}
