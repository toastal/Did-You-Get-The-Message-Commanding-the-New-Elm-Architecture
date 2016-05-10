# Gordon, the Elm Signal
### Reactive-Programming-at-the-Language-Level


* * *


## What is Elm?

Elm is a functional reactive programming language built from the ground up to a be a language for making UIs.

But before we go more into that...


* * *


## How Did We Get Here?


* * *


## jQuery

For better or worse, it changed the game.


- - -

## What Failed and Why Did We Move On

- State was stored in the DOM
- To get state, we'd requery that DOM
- Querying the DOM is slow
- State had to be stored in the DOM
- Or we'd call an API to get brand new DOM
- No single source of truth


* * *


## React's `setState`

React's built-in state management... state no longer tied to the DOM


- - -


## What Failed and Why Did We Move On

- Somewhat controlled, but ultimately imperative and mutative API
- Like jQuery, the data is tied to the 'element'
- Component 'owning' data isn't so cool
- Performance cost of not using pure render
- Passing around state/props to components is a bear
- No single source of truth


* * *


## Myriad of Flux Libraries

A story of stores... state belongs outside the components, data flows one way


- - -


## The real winner here was Redux

- Single state atom
- Encourages you not to use local state (ignore most parts of React)
- Query stores, not state


* * *


## Where did Redux get its inspiration?


* * *


## The Elm Architecture

Literally.
