// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CoinFlip {
    enum LadoMoeda {
        CARA,
        COROA
    }
    enum Resultado {
        GANHADOR,
        PERDEDOR
    }

    event Result(address indexed player, LadoMoeda lado, Resultado result);

    function jogarMoeda(LadoMoeda ladoEscolhido) public {
        uint256 randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender))
        ) % 2;

        LadoMoeda result = LadoMoeda(randomNumber);

        Resultado resultado = (ladoEscolhido == result)
            ? Resultado.GANHADOR
            : Resultado.PERDEDOR;

        emit Result(msg.sender, ladoEscolhido, resultado);
    }
}
