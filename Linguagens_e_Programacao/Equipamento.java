import java.util.Date;
import java.io.Serializable;

public class Equipamento implements IEquipamento {
    private String nome;
    private String tipo;
    private String dataUltimaCalibracao;
    private boolean emFuncionamento;

    public Equipamento(String nome, String tipo, String dataUltimaCalibracao, boolean emFuncionamento) {
        this.nome = nome;
        this.tipo = tipo;
        this.dataUltimaCalibracao = dataUltimaCalibracao;
        this.emFuncionamento = emFuncionamento;
    }

    public String getNome() {
        return nome;
    }

    public String getTipo() {
        return tipo;
    }

    public String getDataUltimaCalibracao() {
        return dataUltimaCalibracao;
    }

    public boolean isEmFuncionamento() {
        return emFuncionamento;
    }

    @Override
    public String toString() {
        return "Equipamento{nome='" + nome + "', tipo='" + tipo + "', dataUltimaCalibracao='" + dataUltimaCalibracao + "', emFuncionamento=" + emFuncionamento + "}";
    }


    public void setEmFuncionamento(boolean emFuncionamento) {
        this.emFuncionamento = emFuncionamento;
    }

}

