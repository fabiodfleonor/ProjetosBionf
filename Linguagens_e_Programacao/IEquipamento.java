import java.io.Serializable;

public interface IEquipamento extends Serializable {
    String getNome();
    String getTipo();
    String getDataUltimaCalibracao();
    boolean isEmFuncionamento();
    String toString();
}
