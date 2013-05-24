# Why we use Puma when testing

We can't use Webrick for the development server when testing. This is because OmniAuth redirects to the relative URL '/auth/callback' after authentication. Webrick (unhelpfully) converts this relative redirect to an absolute redirect (e.g. 'Location: /auth/callback' -> 'Location: http://localhost:3000/auth/callback').

The Karma test runner loads Divvy Up in an iframe and proxies requests from the iframe's src URL to the Rails app. When Webrick redirects the iframe to an absolute URL, the iframe is no longer from the same origin as the surrounding Karma test runner frame and the browser generates cross domain security errors when we try to continue interacting with the iframe. 

Puma (the first alternative server I tried) does not modify the location header, and thus works just fine.
