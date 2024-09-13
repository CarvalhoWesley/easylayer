# easylayer

Um wrapper para a API Easylayer utilizada por produtos da Gertec, como o SK210.

## Sobre

Este pacote tem como objetivo encapsular a API Easylayer, em Java, de forma que possa ser utilizada diretamente do código em Dart.

Buscou-se manter as assinaturas dos métodos o mais fiéis possível, apesar das diferenças entre as linguagens, como a ausência de sobrecarga de métodos em Dart.

## Pré-requisitos

É necessário baixar o SDK Easylayer, disponibilizado no [Portal do Desenvolvedor](https://developer.gertec.com.br/), e adicioná-lo como uma dependência do seu projeto:

+ Baixe o arquivo do SDK, por exemplo `EasyLayer-SK210-v2.1.7-release.aar`.

+ Adicione o arquivo do sdk ao seu projeto, por exemplo `android/app/libs/`.

+ Adicione o trecho abaixo ao arquivo `android/app/build.gradle` com o caminho correspondente a onde instalou o SDK, por exemplo:

    ```
    dependencies {
        implementation files('libs/EasyLayer-SK210-v2.1.7-release.aar')
    }
    ```

## Disclaimer

+ Este pacote não tem qualquer afiliação com a Gertec. Ele foi desenvolvido de forma independente para facilitar a integração com o software da empresa. Todas as marcas e nomes comerciais mencionados pertencem aos seus respectivos proprietários.