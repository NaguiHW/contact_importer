# Contact Importer

This is an application where you can upload a csv file and import the data to the database.

**IMPORTANT:**
The data has to have a specific format, otherwise it is not going to load the information.

## Instalation
- Clone repository
```
git clone git@github.com:NaguiHW/contact_importer.git
```
- Install repository

**If you are not in the directory use this command, otherwise use the next line.**
```
cd contact_importer/
```
```
bundle
```
This project use `postgresql` as the databse, so we have to create it.
```
rails db:create
```
```
rails db:migrate
```
We are usign `Lockbox` to encrypt the credit cards, so we have to initialize the master key.

You can use the following key:
```
6382010320f6e9e6b197a583762ad87db34444a30b2ff3039a99671002994c66
```
And now we have to add it to our credentials:
```
EDITOR="code --wait" bin/rails credentials:edit
```
**IMPORTANT: I am using vscode to edit the crdentials, that is why in `EDITOR` is `code` inside. You can use `VIM` or other editor if you want.**
```
EDITOR="VIM" bin/rails credentials:edit
```
For more documentation about the gem click [here](https://www.rubydoc.info/gems/lockbox/0.6.4).

The credentials has to look like this:
```
lockbox:
  master_key: "6382010320f6e9e6b197a583762ad87db34444a30b2ff3039a99671002994c66"
```

## Routes
- By default the root route is http://localhost:3000. Here you can import the files.
- Watch all CSVs uploaded to process the data http://localhost:3000/all_csvs. Also if you have already uploaded data, you can watch it here.
