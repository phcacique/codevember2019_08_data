# Codevember 2019 - Day 08: data

## About Codevember
[Codevember](http://codevember.xyz) is a challenge for developers to sharpen their creativity and improve their skills. The goal is to build a creative piece of code every day of November. We give you daily hints to inspire you but you can do unrelated sketches.

## About this app
![preview image](/images/08_data.PNG)

Conway's Game of Life is a "game" based on the relationship between cells in a grind and their neighbors. Each cell can assume one state (dead or alive). If a cell is alive, but has only one or none alive neighbors, it will die in the next generation by solitude. If it is alive and has more than 3 alive neighbors, it will die by overpopulation. In the other side, if a cell is dead and has exactly 3 neighbors, it will be born. Cells with 2 or 3 neighbors can survive to next generation.

In this app, we can see the data behind the process. We can see the number of a cell neighbors and the colors indicates their future: 
- green: it survives
- red: it dies
- yellow: it will be born

_This is an iOS app, made in Swift, on XCode and it is a free visual experiment._
