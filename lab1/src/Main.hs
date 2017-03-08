module Main where
import Lab1 (lab1start)
import Lab2 (lab2start)
import Data.Monoid ((<>))

{-makeList 0 = []
makeList n = makeList(div n 10) ++ [mod n 10]


hello :: String -> String
hello s = "Hello, " <> s
main :: IO ()
main = do
    let x = [1,2,4]
    let y = x++[13,5]
    putStrLn( show y)-}
--main=print(lab1start)
main=lab2start
