# mvvm_provider

A example flutter app movies using [MVVM](https://learn.microsoft.com/pt-br/windows/uwp/data-binding/data-binding-and-mvvm) with [Bloc](https://pub.dev/packages/bloc) and [flutter_bloc](https://pub.dev/packages/flutter_bloc) state management.

## Getting Started

`git clone git@github.com:kauemurakami/mvvm_bloc.git`
<br/>

**Create account** in [The movie db](https://www.themoviedb.org/).
After, click in your picture/initial letter name circle in top right, find `settings`, in `settings` find for `API` and you can see your API's `api key` and `token`.
<br/>

#### Create file .env
In your project root folder, in the case is `mvvm_provider`, right click, select the option `create folder` named it with `assets`, inside `create file` with name `.env`. Now in your `pubspec.yaml` go at section `assets`.
```yaml
assets:
    - assets/.env
```
```.env
MOVIES_API_KEY = "YOUR_API_KEY"
MOVIES_BEARERTOKEN = "YOUR_API_TOKEN"
```
Add `*.env` in your `gitignore`

#### Run project

`flutter packages get`
<br/>

`flutter run`
