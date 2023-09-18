// SPDX-LICENSE-IDENTIFIER: UNLICENSED

pragma solidity ^0.8.13;

contract CaixinhaDeGorjetas {
    // O endereço do dono do contrato
    address public dono;

    // Evento que é emitido quando uma gorjeta é recebida
    event GorjetaRecebida(address indexed de, uint256 valor);

    // Evento que é emitido quando uma gorjeta é retirada
    event GorjetaRetirada(address indexed para, uint256 valor);

    // Construtor que define o dono do contrato como o criador do contrato
    constructor() {
        dono = msg.sender;
    }

    // Modificador que permite apenas que o dono do contrato chame funções específicas
    modifier somenteDono() {
        require(msg.sender == dono, "Somente o dono pode chamar essa funcao");
        _;
    }

    // Função para enviar uma gorjeta para o contrato
    function darGorjeta() public payable {
        require(msg.value > 0, "O valor da gorjeta deve ser maior que 0");
        emit GorjetaRecebida(msg.sender, msg.value);
    }

    // Função para o dono retirar todas as gorjetas do contrato
    function retirarGorjetas() public somenteDono {
        uint256 saldoDoContrato = address(this).balance;
        require(
            saldoDoContrato > 0,
            "O saldo do contrato deve ser maior que 0"
        );

        payable(dono).transfer(saldoDoContrato);
        emit GorjetaRetirada(dono, saldoDoContrato);
    }

    // Função para obter o saldo atual do contrato
    function obterSaldo() public view returns (uint256) {
        return address(this).balance;
    }
}
