import '../models/story_model.dart';

class StorySeed {
  static const List<StorySeedEntry> preloaded = [
    StorySeedEntry(
      title: 'The Fox and the Grapes',
      text: 'A hungry fox was walking through a forest when he saw a bunch of grapes hanging from a high branch. "Just the thing to quench my thirst," he said. He jumped to reach the grapes, but they were too high. He tried again and again, but each time he failed. Finally, he gave up and walked away, saying, "Those grapes are probably sour anyway." The moral of the story is that it is easy to despise what you cannot have.',
    ),
    StorySeedEntry(
      title: 'The Tortoise and the Hare',
      text: 'A hare was boasting about how fast he could run. He laughed at the tortoise for being slow. The tortoise challenged him to a race. The hare ran quickly and soon was far ahead. Confident of winning, he decided to take a nap under a tree. The tortoise kept walking slowly but steadily. When the hare woke up, he saw the tortoise was near the finish line. He ran as fast as he could, but it was too late. The tortoise had won the race. The moral is that slow and steady wins the race.',
    ),
    StorySeedEntry(
      title: 'The Boy Who Cried Wolf',
      text: 'A young shepherd boy was watching over his flock near a village. To have some fun, he cried out, "Wolf! Wolf!" The villagers came running to help him, only to find there was no wolf. The boy laughed at them. He did the same thing several times, and each time the villagers came running for nothing. One day, a real wolf came. The boy cried out for help, but the villagers thought he was joking again. They did not come, and the wolf attacked the sheep. The moral is that liars are not believed even when they tell the truth.',
    ),
    StorySeedEntry(
      title: 'The Ant and the Grasshopper',
      text: 'In a field one summer\'s day, a grasshopper was hopping about, chirping and singing to his heart\'s content. An ant passed by, carrying a huge ear of corn to his nest. "Why not come and chat with me?" said the grasshopper. "I am helping to store food for the winter," said the ant, "and I recommend you do the same." But the grasshopper laughed and continued to play. When winter came, the grasshopper had no food and was starving. He went to the ant\'s nest and begged for food. The ant replied, "Since you sang all summer, you can dance all winter."',
    ),
    StorySeedEntry(
      title: 'The City Mouse and the Country Mouse',
      text: 'A country mouse invited his cousin from the city to visit. The city mouse was bored with the simple country food and quiet life. He convinced the country mouse to come to the city for a feast. In the city, they found wonderful food on a table in a grand house. But just as they began to eat, a cat appeared and chased them away. The country mouse decided to return home, saying, "Better a simple meal in peace than a feast in fear."',
    ),
    StorySeedEntry(
      title: 'The Lion and the Mouse',
      text: 'A lion was sleeping when a little mouse ran across his nose and woke him up. The lion caught the mouse and was about to eat him. The mouse begged for his life, saying, "Please let me go, and one day I will repay you." The lion laughed at the idea that a tiny mouse could help him, but he let the mouse go. Later, the lion was caught in a hunter\'s net. He roared in anger, but could not escape. The mouse heard him and gnawed through the ropes with his teeth, freeing the lion. The moral is that even small friends can be great helpers.',
    ),
    StorySeedEntry(
      title: 'The Wind and the Sun',
      text: 'The wind and the sun were arguing about who was stronger. They saw a traveler walking on the road and decided to test their strength. The wind said, "I will make him take off his coat." The wind blew with all its might, but the harder it blew, the tighter the traveler held his coat. Then the sun shone warmly. The traveler felt the heat and took off his coat. The sun proved that gentleness and warmth are more powerful than force and anger.',
    ),
    StorySeedEntry(
      title: 'The Crow and the Pitcher',
      text: 'A crow was very thirsty after a long flight. He found a pitcher with a little water at the bottom, but his beak could not reach it. He tried to push the pitcher over, but it was too heavy. Then he had an idea. He picked up small pebbles and dropped them into the pitcher one by one. As the pebbles fell, the water level rose. Finally, the water was high enough for him to drink. The moral is that little by little does the trick.',
    ),
  ];
}

class StorySeedEntry {
  final String title;
  final String text;
  const StorySeedEntry({required this.title, required this.text});
}
