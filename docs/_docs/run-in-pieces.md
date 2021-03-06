---
title: Run in Pieces
---

The `ufo ship` command goes through a few stages:

1. building the docker image
2. registering the task defiintions
2. updating the ECS service.

The CLI exposes many of these steps as separate commands.  Here is now you would be able to run each of the steps in pieces.

Build the docker image first.

```bash
ufo docker build
ufo docker push # pushes last built image to a registry
```

Build the task definitions.

```bash
ufo tasks build    # generates task definition json files to .ufo/output
ufo tasks register # registers all genreated task definitions .ufo/output to ECS
```

Update the service with the task definitions in `.ufo/output` untouched.

```bash
ufo deploy demo-web
```

Note if you use the `ufo deploy` you should ensure that you have already pushed the docker image to your docker registry.  Or else the task will not be able to spin up because the docker image does not exist.  This is one of the reasons it is recommended that you use `ufo ship`.

<a id="prev" class="btn btn-basic" href="{% link _docs/upgrade4.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/single-task.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>
