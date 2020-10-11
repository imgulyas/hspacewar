module Main (main) where

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game
import Graphics.Gloss.Interface.IO.Simulate

window :: Display
window = InWindow "HSpacewar" (500, 500) (300, 300)

-- data Player = P1
--             | P2
--             deriving stock Eq

data Control = Control { leftPressed :: Bool
                       , rightPressed :: Bool
                       , forwardPressed :: Bool
                       , firePressed :: Bool
                       }

unpressed :: Control
unpressed = Control False False False False

data Model = Model { debugMode :: Bool
                   , p1Control :: Control
                   }

initModel :: Model
initModel =  Model { debugMode = True
                   , p1Control = unpressed
                   }


orangeCircle = Color orange $ thickCircle 80 40

dot = thickCircle 0.5 1
dotCoords = [-300, -250 .. 300]
dotsWithText = do
                x <- dotCoords
                y <- dotCoords
                color white . translate x y
                  <$> [dot, scale 0.03 0.03 $ text $ show (x, y)]
 
pics = orangeCircle : dotsWithText

renderModel :: Model -> IO Picture
renderModel _ = pure $ Pictures pics

handleInputEvent :: Event -> Model -> IO Model
handleInputEvent _ model = pure model

stepModel :: Float -> Model -> IO Model
stepModel _ model = pure model

main :: IO ()
-- main = playIO
--        window
--        black             -- Background color.
--        30                -- Number of simulation steps to take for each second of real time.
--        initModel
--        renderModel       -- An action to convert the model into a picture.
--        handleInputEvent
--        stepModel         -- A function to step the world one iteration.
                            -- It is passed the period of time (in seconds) needing to be advanced.

main = simulateIO
       window
       black
       30
       initModel
       renderModel
       (\vp -> stepModel)
