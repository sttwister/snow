## Installation

```
pip3 install virtualenv 
virtualenv .venv
pip3 install -r requirements.txt
```

## Usage

```
./update.sh
```

## Local preview

```
./update.sh
python3 -m http.server 8000 --directory dist
```

Then open http://localhost:8000/. The "Show all webcams" choice and resorts opened with
"open webcams" are stored in the browser's localStorage (`snow:showWebcams`,
`snow:openedWebcams`); if storage is blocked the page still works, it just won't remember them.
