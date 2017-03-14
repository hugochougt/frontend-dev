namespace :rangularis do
  namespace :fake_data do
    desc 'Generate fake recipes data'
    task :generate => :environment do
      recipes = [
        {
          name: 'Baked Potato w/ Cheese',
          instructions: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illo, libero itaque soluta facere neque tempore nemo expedita commodi fugiat exercitationem enim inventore at unde! Maxime optio, minus modi. Dolorum, placeat?'
        },
        {
          name: 'Garlic Mashed Potatoes',
          instructions: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Qui ab, beatae? Soluta saepe sit nihil beatae culpa illum, at eius debitis minus obcaecati fuga, laborum laudantium. Ipsa corporis atque veritatis?'
        },
        {
          name: 'Potatoes Au Gratin',
          instructions: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rerum, ducimus, sint. Officiis facilis totam, ut numquam non excepturi voluptatibus sed culpa. Repellendus officiis, cumque dicta a minus velit pariatur aliquam?'
        },
        {
          name: 'Baked Brussel Sprouts',
          instructions: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore error qui aspernatur. Eaque fugit, vero dolorum doloribus voluptatum illum nulla quasi dolorem! Tempora debitis quisquam inventore fugit, sapiente, dignissimos distinctio.'
        }
      ]

      recipes.each do |recipe|
        new_recipe = Recipe.create(recipe)
        puts "[SUCCESS] #{new_recipe.name} created." if new_recipe.id
      end
    end
  end
end