import java.io.Serializable;

public class Medicao implements Serializable {
    private static final long serialVersionUID = 1L;
    private String tipo;
    private double valorObtido;
    private String dataHora;

    public Medicao(String tipo, double valorObtido, String dataHora) {
        this.tipo = tipo;
        this.valorObtido = valorObtido;
        this.dataHora = dataHora;
    }

    public String getTipo() {
        return tipo;
    }

    public double getValorObtido() {
        return valorObtido;
    }

    public String getDataHora() {
        return dataHora;
    }

    @Override
    public String toString() {
        return "Medicao{" +
                "tipo='" + tipo + '\'' +
                ", valorObtido=" + valorObtido +
                ", dataHora='" + dataHora + '\'' +
                '}';
    }
}
