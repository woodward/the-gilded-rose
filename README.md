# The Gilded Rose

This exercise was the [Elixir directory](https://github.com/mechanical-orchard/the-gilded-rose/tree/main/implementations/elixir) 
from [The Gilded Rose](https://github.com/mechanical-orchard/the-gilded-rose)
The Mechanical Orchard repo is a private fork of [lexun's repo](https://github.com/lexun/the-gilded-rose) 
(which seems to no longer exist or is no longer public).  

This is my implementation of the problem in Elixir.

The original README is below; note that the checkboxes indicate that test coverage has been created for
that particular requirement.

Greg Woodward
2024-08-16

----------------------------------------------------------------------------------------------------

# The Gilded Rose

Hi and welcome to team Gilded Rose.

As you know, we are a small inn with a prime location in a prominent city ran by
a friendly innkeeper named Allison. We also buy and sell only the finest goods.
Unfortunately, our goods are constantly degrading in quality as they approach
their sell by date.

We have a system in place that updates our inventory for us. It was developed by
a no-nonsense type named Leeroy, who has moved on to new adventures. Your task
is to add the new feature to our system so that we can begin selling a new
category of items.

First an introduction to our system:

- [x] All items have a _sell_in_ value which denotes the number of days we have to
  sell the item

- [x] All items have a _quality_ value which denotes how valuable the item is

- [x] At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

- [x] Once the _sell_in_ days is less then zero, _quality_ degrades twice as fast
  GW: Current code seems to do less than or equal to zero (verify) for a generic item

- [x] The _quality_ of an item is never negative

- [x] "Aged Brie" actually increases in _quality_ the older it gets

- [x] The _quality_ of an item is never more than 50

- [x] "Sulfuras", being a legendary item, never has to be sold nor does it decrease
  in _quality_

- [x] "Backstage passes", like aged brie, increases in _quality_ as it's _sell_in_
  value decreases; _quality_ increases by 2 when there are 10 days or less and
  by 3 when there are 5 days or less but _quality_ drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to
our system:

- [x] "Conjured" items degrade in _quality_ twice as fast as normal items

Feel free to make any changes to the _updateQuality_ method and add any new code
as long as everything still works correctly. However, do not alter the _Item_
module as that belongs to the goblin in the corner who will insta-rage and
one-shot you as he doesn't believe in shared code ownership.

- [x] Just for clarification, an item can never have its _quality_ increase above 50
  
- [x] however "Sulfuras" is a legendary item and as such its _quality_ is 80 and it
never alters.

## Meta Instructions

Consider this an exercise in refactoring a legacy system to make your feature
easier to implement, and leave things in a more maintainable state than you
found them in.

As with most legacy systems, we can't count on this one to fully follow the
spec, and we should consider the possibility that it contains bugs that other
systems compensate for and therefore depend on. Even though this example is
small, let's pretend it's a legitimate legacy system that would be impractical
to rewrite.

To complete the exercise, perform a gradual, step by step refactoring, showing
your work with micro-commits at each step. Implement "Conjured" items when the
code has improved enough to make it easy and clear. Aside from the point at
which you implement the "Conjured" items spec, preserve all existing legacy
behavior at each step/commit.

You'll need to initialize a new git repository to start:

```
git init
git add -A
git commit -m "Initial commit"
```

And you can package up a bundle of your completed work with:

```
git bundle create your_name.bundle master
```
