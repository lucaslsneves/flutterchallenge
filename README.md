# Flutter Challenge

# Telas

## Login
![login](https://user-images.githubusercontent.com/53489804/86472256-42bf0800-bd15-11ea-827b-e9a4a434413e.jpeg)

<br/>
<br/>
<br/>

## Galeria
![Galeria](https://user-images.githubusercontent.com/53489804/86472531-ac3f1680-bd15-11ea-97c7-a0df69536ffb.jpeg)

<br/>
<br/>
<br/>

## Seleção de foto
![Seleção de fotos](https://user-images.githubusercontent.com/53489804/86472594-c2e56d80-bd15-11ea-9177-5ba599f8ca53.jpeg)
<br/>
<br/>
<br/>

## Seleção de foto (Foto ja selecionada)
![foto selecionada](https://user-images.githubusercontent.com/53489804/86472641-dbee1e80-bd15-11ea-9306-e269b7e744db.jpeg)

<br/>
<br/>
<br/>
 
## Reedimensionar foto
![Reedimensionar](https://user-images.githubusercontent.com/53489804/86472664-e6101d00-bd15-11ea-86d6-ea28e90781e8.jpeg)

<br/>
<br/>
<br/>

## Barra de progresso enquanto o arquivo está sendo upado na Storage
![progresso](https://user-images.githubusercontent.com/53489804/86472734-05a74580-bd16-11ea-8bb2-99482a47e782.jpeg)

<br/>
<br/>
<br/>

## Sobre
 O App exibe uma galeria de imagens armazenadas em um banco de dados Cloud Firestore - Firebase.

 ## Funcionalidades

 - Login com google
 - Adição de uma nova imagem
 - Reedimensionar a imagem antes de adiciona-la 

 Ao adicionar uma nova imagem ela é armazenada no Storage do firebase e um novo registro
 é criado na Collection chamada images no Cloud Firestore.

 Neste registro são guardados os campos: 

 - url (Url da imagem)
 - createdAt (Data de criação)
 - UpdatedAt (Data de atualização)
 - title (Título da imagem (por padrão todos os titulos estão recebendo o valor "Título"))
 - description (Descrição da imagem (por padrão todas as descrições estão recebendo o valor "Lorem Ipsum Descrição"))

 Assim que a imagem é adicionada o usuário e redirecionado para a Galeria de fotos onde os as fotos são organizadas por 
 data de criação (A imagem mais recente no topo).

O usuário pode selecionar uma imagem para ser adicionada diretamente pela sua câmera ou selecionar uma da sua galeria,
das duas maneiras será possível reedimenionar a imagem antes de adiciona-la.
