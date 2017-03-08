
module Lab2 where
import Control.Concurrent
import Control.Monad (forever)
import Control.Concurrent.Chan

taxi chanIn chanClient = do

    niceTry <- readChan chanIn
    putStrLn "Taxi: manager to taxi"
    writeChan chanClient "taxi"

laundry chanIn chanManager = do

    niceTry <- readChan chanIn
    putStrLn "Laundry: manager to laundry"
    writeChan chanManager "laundry_client"

restorant chanIn chanClient = do
    niceTry <- readChan chanIn
    putStrLn "Restorant: client to restorant"
    writeChan chanClient "restorant"


client chanIn chanManager chanRestorant = do
--    writeChan chanManager "client_in"

    niceTry <- readChan chanIn
    case niceTry of
        "manager_ok" -> do
            putStrLn "Client: manager to client Ok"
            putStrLn "Client: client to laundry"
            writeChan chanManager "client_laundry"
        "manager_exit" -> do
            putStrLn "Client: manager to client Exit"
            putStrLn "Client: client restart"
            writeChan chanManager "client_in"
        "laundry_ok" -> do
            putStrLn "Client: laundry to client"
            putStrLn "Client: client to restorant"
            writeChan chanRestorant "client"
        "taxi" -> do
            putStrLn "Client: taxi to client"
            putStrLn "Client: client exit"
            writeChan chanManager "client_exit"
        "restorant" -> do
            putStrLn "Client: restotant to client"
            putStrLn "Client: client to taxi"
            writeChan chanManager "client_taxi"


manager chanIn taxiChan clientChan laundryChan = do

    niceTry <- readChan chanIn
    case niceTry of
        "client_laundry" -> do
            putStrLn "Manager: client to laundry"
            writeChan laundryChan "manager"
        "laundry_client" -> do
            putStrLn "Manager: client to laundry"
            writeChan clientChan "laundry_ok"
        "client_taxi" -> do
            putStrLn "Client: taxi to client"
            writeChan taxiChan "manager"
        "client_exit" -> do
            putStrLn "Client: taxi to client"
            writeChan clientChan "manager_exit"
        "client_in" -> do
            putStrLn "Manager: redister client "
            writeChan clientChan "manager_ok"


forkCreator action = forkIO $ forever action

lab2start :: IO ()
lab2start = do
    taxiChan <- newChan
    clientChan <- newChan
    managerChan <- newChan
    restorantChan <- newChan
    laundryChan <- newChan

    forkCreator $ taxi taxiChan clientChan
    forkCreator $ restorant restorantChan clientChan
    forkCreator $ laundry laundryChan managerChan
    forkCreator $ manager managerChan taxiChan clientChan laundryChan
    forkCreator $ client clientChan managerChan restorantChan
    writeChan managerChan "client_in"

    getLine
    return ()


