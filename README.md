# Flutter Challenge

## Telas

- Login

- Galeria

- Seleção de foto

- Reedimensionar foto (se quiser)


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
