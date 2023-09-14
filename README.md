# www.arjunsatarkar.net

See [the live site](https://www.arjunsatarkar.net/).

## Notice

<span>www</span>.<span>arjunsatarkar</span>.<span>net</span> is copyright © 2023-present Arjun Satarkar.

It is intended specifically and only to run https://www.arjunsatarkar.net, and is not useful as a generic static site generator or CMS.

## Usage

Prerequisites:
- [Python](https://www.python.org/downloads/) 3.11 or later (might work on some earlier versions)
- [Asciidoctor](https://asciidoctor.org/)

Initial setup:
```bash
git clone https://scm.arjunsatarkar.net/www.arjunsatarkar.net/
cd www.arjunsatarkar.net/
python -m venv ./venv/
source venv/bin/activate
pip install -r requirements.txt
```

Build site:
```bash
./build.sh
```

Serve site:
```bash
./serve.py
```
