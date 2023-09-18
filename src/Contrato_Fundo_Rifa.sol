// SPDX-LICENSE-IDENTIFIER: UNLICENSED
pragma solidity ^0.8.13;

contract ContratoFundo {
    address public dono;
    uint256 public saldo;

    event PremioDistribuido(address ganhador, uint256 valor);

    constructor() {
        dono = msg.sender;
    }

    modifier somenteDono() {
        require(msg.sender == dono, "Somente o dono pode chamar essa funcao");
        _;
    }

    function depositar() public payable somenteDono {
        saldo += msg.value;
    }

    function distribuirPremio(address ganhador) external somenteDono {
        require(saldo > 0, "Saldo insuficiente");
        uint256 valorPremio = saldo;
        saldo = 0;
        payable(ganhador).transfer(valorPremio);

        emit PremioDistribuido(ganhador, valorPremio);
    }
}
