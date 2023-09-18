// SPDX-LICENSE-IDENTIFIER: UNLICENSED
pragma solidity ^0.8.13;

import {Chainlink} from "@thirdweb-dev/chains-chainlink";

contract Rifa {
    address public dono;
    uint256 public precoNumero = 0.0001 ether; // Preço fixo por número
    uint256 public comissao = 10; // 10% de comissão
    uint256 public numeroMaximo = 100; // 100 números disponíveis
    mapping(uint256 => address) public compradores;
    uint256[] public numerosDisponiveis;

    event NumeroComprado(address indexed comprador, uint256 numero);
    event SorteioRealizado(address indexed ganhador, uint256 numeroSorteado);

    constructor() {
        dono = msg.sender;
        for (uint256 i = 1; i <= numeroMaximo; i++) {
            numerosDisponiveis.push(i);
        }
    }

    modifier somenteDono() {
        require(msg.sender == dono, "Somente o dono pode chamar essa funcao");
        _;
    }

    function comprarNumero(uint256 numero) public payable {
        require(msg.value == precoNumero, "Valor incorreto enviado");
        require(
            numero >= 1 && numero <= numeroMaximo,
            "Numero fora do intervalo permitido"
        );
        require(compradores[numero] == address(0), "Numero ja foi comprado");

        uint256 valorComissao = (msg.value * comissao) / 100;
        uint256 valorFundo = msg.value - valorComissao;

        payable(dono).transfer(valorComissao);
        // Aqui você deve adicionar a lógica para transferir valorFundo para o contrato do fundo

        compradores[numero] = msg.sender;

        for (uint256 i = 0; i < numerosDisponiveis.length; i++) {
            if (numerosDisponiveis[i] == numero) {
                numerosDisponiveis[i] = numerosDisponiveis[
                    numerosDisponiveis.length - 1
                ];
                numerosDisponiveis.pop();
                break;
            }
        }

        emit NumeroComprado(msg.sender, numero);
    }

    function realizarSorteio() public somenteDono {
        uint256 numeroSorteado = (block.number % numeroMaximo) + 1;
        address ganhador = compradores[numeroSorteado];
        require(ganhador != address(0), "Numero sorteado nao foi comprado");

        // Aqui você deve adicionar a lógica para distribuir o prêmio ao ganhador

        emit SorteioRealizado(ganhador, numeroSorteado);
    }

    function getNumerosDisponiveis() public view returns (uint256[] memory) {
        return numerosDisponiveis;
    }
}
