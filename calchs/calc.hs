import System.Environment
import Data.List

main = do
    (cmd:exp:_) <- getArgs
    let result = dispatch cmd exp
    putStrLn result

dispatch :: String -> (String -> String)
dispatch "num" = solveRPN'
dispatch "logic" = solveLogicRPN'
dispatch _ = error "Unrecognized command"

solveRPN' :: String -> String
solveRPN' exp = if (isInt result) then show (truncate result) else show result
    where result = solveRPN exp

solveRPN :: String -> Float
solveRPN expression = head (foldl action [] (words expression))
    where action (x:y:ys) "+" = (x + y):ys
          action (x:y:ys) "-" = (x - y):ys
          action (x:y:ys) "*" = (x * y):ys
          action (x:y:ys) "/" = (x / y):ys
          action (x:xs) "neg" = (0 - x):xs
          action xs     "sum" = [sum xs]
          action xs "product" = [product xs]
          action xs numStr    = read numStr :xs

isInt :: Float -> Bool
isInt x = x == fromInteger (round x)

solveLogicRPN' :: String -> String
solveLogicRPN' = show . solveLogicRPN

solveLogicRPN :: String -> Bool
solveLogicRPN = head . foldl action [] . words
    where action (x:y:ys) "|" = (x || y):ys
          action (x:y:ys) "&" = (x && y):ys
          action (x:ys)   "~" = (not x) :ys
          action (xs)   "and" = [and xs]
          action (xs)    "or" = [or xs]
          action xs      "T"  = True:xs
          action xs      "F"  = False:xs
