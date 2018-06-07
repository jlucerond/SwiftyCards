# SwiftyCards
Learn Swift, swfitly.

SwiftyCards is a swipe-based flashcard app. Get a question right, swipe right. My algorithm will keep track of the questions that you've seen most recently and how often you've gotten right and give you an overall grade on how you're doing in each category. I worked on this project to work on making custom views in Swift. Here's a few of the parts of Swfit that I learned a lot about:

1. CALayers:
I used CAGradient Layers for the top of the flashcard along with layer attributes for rounding corners, adding borders and shadows, showing progress on a rounded dial, and making the overall look of the app different than Apple's stock objects.

2. Animations:
The flip animation to show the "back" of the card was an Apple stock animation. As the card swipes left or right I used animations to swipe the card off to the screen, re-draw the card with the bottom card's view, place it back on the bottom card's frame, update the bottom card, and then animate the top card down with the bottom card now showing a new card. I also animated images of green checks or red x's to show the user whether they were getting a question right or wrong. And the custom animation transitions made it appear as the detail VCs were coming from inside of the buttons at the bottom of the page.

3. Core Data:
Core Data was used to keep track of the various properties of each card and how the user was doing with progress through the deck. I used the "Find or Create" technique to load cards from JSON if it was the first time the user was loading the app. Every subsequent time the user loads the app, they will load the objects from Core Data.

Other Skills:
IBDesignable & IBInspectable, Codable & JSONDecoder, General Programming Knowledge for creating the cards.
