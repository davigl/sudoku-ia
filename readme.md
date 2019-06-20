### Algoritmo bio-inspirado nas Algas

Alga é o nome comum de um diversificado agrupamento polifilético de organismos fotossintéticos cujo ciclo de vida se completa geralmente em meio aquático.

Estima-se que cerca de 90 porcento do oxigênio presente na atmosfera terrestre seja gerado pela fotossíntese das algas planctônicas. 

```
    *  *          /*._   
 *  *'*  *'*   .-*'`   `*-.._.-'/"
*'* *'*   **  < * ))     ,     ( "
*'*  *'* **    `*-._`._(__.--*`."
 *'*  *' *   
  *'* *'**   o        /\
  *'* *'**    o     _/./
   *'*'**   O    ,-'    `-:..-'/
     **         : o )      _  (
     	        "`-....,--; `-.\
```

### Problema

As algas são dispostas em um espaço de busca <strong> (Oceano) </strong> e devem solucionar um sudoku de tamanho N a partir da produção de oxigênio utilizando fotossíntese.

As algas se movimentam para os pontos de produção de nutrientes no espaço de busca a partir das funções <strong> search_nutrients </strong> e <strong> ocean_localization </strong>.

### Regras

```
 * As algas que produzem baixas taxas de oxigênio serão eliminadas do oceano.
   As algas unicelulares que produzem altas taxas de oxigênio irão se reproduzir por divisão binária.
   As algas no oceano também podem se reproduzir por fragmentação, e terá chances de 1 porcento de ocorrer a cada geração.
```

### License

Copyright © 2019, [Davi Guimarães](https://github.com/davigl).