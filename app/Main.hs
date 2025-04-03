{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Network.Wai.Middleware.Static
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text

main :: IO ()
main = do
  putStrLn "Запуск сервера на http://localhost:3000"
  scotty 3000 $ do
    -- Обслуживание статических файлов из директории 'static'
    middleware $ staticPolicy (addBase "static")
    
    get "/" $ do
      html $ renderHtml $ homePage "Добро пожаловать!"

-- Функция для создания HTML-страницы
homePage :: String -> H.Html
homePage greeting = H.docTypeHtml $ do
  H.head $ do
    H.meta H.! A.charset "utf-8"
    H.meta H.! A.name "viewport" H.! A.content "width=device-width, initial-scale=1.0"
    H.title "Haskell Greeting App"
    -- Подключение Tailwind CSS через CDN
    H.link H.! A.rel "stylesheet" H.! A.href "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
  
  H.body H.! A.class_ "bg-gray-100 h-screen" $ do
    H.div H.! A.class_ "flex items-center justify-center h-full" $ do
      H.div H.! A.class_ "bg-white p-8 rounded-lg shadow-md" $ do
        H.h1 H.! A.class_ "text-3xl font-bold text-center text-gray-800" $ H.toHtml greeting
        H.p H.! A.class_ "mt-4 text-center text-gray-600" $ "Сайт создан на Haskell с использованием Tailwind CSS"