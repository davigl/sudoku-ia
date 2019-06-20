### Algoritmo bio-inspirado nas Algas

O seguinte algoritmo é de busca e otimização baseada em bio-inspiração no ser vivo Alga e segue o padrão dos algoritmos de inteligência artificial desse segmento onde possuem as seguintes características:

```
1 Cria-se os candidatos à solução
2 Avalia-se os candidatos
3 Permite a adaptação com base nos melhores
4 Seleciona-se os que serão substituídos
5 Cria nova geração/grupo e volta ao passo 2 até alcançar a condição de parada.
```

### Sobre a Alga

Alga é o nome comum de um diversificado agrupamento polifilético de organismos fotossintéticos cujo ciclo de vida se completa geralmente em meio aquático.

Estima-se que cerca de 90 porcento do oxigênio presente na atmosfera terrestre seja gerado pela fotossíntese das algas planctônicas. 

As algas, tanto as unicelulares como as multicelulares, apresentam reprodução assexuada e sexuada. Nas algas unicelulares a reprodução assexuada ocorre por divisão binária, com um indivíduo dando origem a dois outros. No caso das algas multicelulares, esse tipo de reprodução pode ocorrer por fragmentação do talo, como é comum nas algas filamentosas, ou por zoosporia. Neste processo, um indivíduo forma células flageladas chamadas de zoósporos que soltam-se e, ao fixar-se em algum substrato, originam novos indivíduos.

Muitas espécies de algas são seres unicelulares, vivendo livres na água e movendo-se com o auxílio de flagelos ou por movimento amebóide. Algumas espécies não têm movimento próprio e ocorrem no meio ambiente quer na forma cocóide (de coccus, o tipo mais simples de bactéria), quer na forma capsóide, cobertas de mucilagem. No entanto, mesmo as algas unicelulares se agrupam por vezes em formas coloniais, móveis ou não.

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
   As algas que produzem baixas taxas de oxigênio serão eliminadas do oceano.
   As algas unicelulares que produzem altas taxas de oxigênio irão se reproduzir por divisão binária.
   As algas no oceano também podem se reproduzir por fragmentação, e terá chances de 1 porcento de ocorrer a cada geração.
```

### License

Copyright © 2019, [Davi Guimarães](https://github.com/davigl).