-----------------------------------------------------------------------------
--
-- Module      :  Lab1
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Lab1 where

data Tree v = Leaf v | Mul (Tree v) (Tree v) | Div (Tree v) (Tree v) | Plus (Tree v) (Tree v) | Minus (Tree v) (Tree v)

calc (Mul left right) = calc left * calc right
calc (Div left right) = calc left / calc right
calc (Plus left right) = calc left + calc right
calc (Minus left right) = calc left - calc right
calc (Leaf value) = value

lab1start = do
    calc (Plus (Div (Plus (Leaf 5) (Leaf 4)) (Minus (Leaf 4) (Leaf 1))) (Leaf 0.5))


