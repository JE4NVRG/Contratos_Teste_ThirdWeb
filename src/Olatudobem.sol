// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MeuPrimeiroContratoThirdWeb {
    string public message;

    // Construtor para inicializar a mensagem com um valor padrão
    constructor() {
        message = "Ola Mundo, tudo bem?";
    }

    // Função para obter a mensagem atual
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Função para alterar a mensagem (opcional)
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
}
