require 'faker'

Category.delete_all
Category.create(name: "Livros", emoji: "📚", order: 1)
Category.create(name: "Músicas", emoji: "🎵", order: 2)
Category.create(name: "Filmes/Séries", emoji: "🎬", order: 3)
Category.create(name: "Podcast", emoji: "🎙", order: 4)
Category.create(name: "Jogos", emoji: "👾", order: 5)
Category.create(name: "Beleza", emoji: "💄", order: 7)
Category.create(name: "Comida", emoji: "🍔", order: 8)
Category.create(name: "Cursos", emoji: "🎓", order: 9)
Category.create(name: "Eletrônicos", emoji: "💻", order: 10)
