# README

This is to describe a simple implementation of using a Stimulus controller to listen to a channel and replace the content of a data stream. It uses two Le Wagon lectures as inspiration for the code: [Action Cable](https://kitt.lewagon.com/camps/279/lectures/06-Projects%2F01-Pundit#source) and [Sidekiq](https://kitt.lewagon.com/camps/279/lectures/06-Projects%2F03-Advanced-Admin)

The core points are the following:

1. Install Sidekiq to handle async background jobs
2. Create a new job ( PostUpdateJob for this example )
3. Create a new Channel ( PostChannel for this example )
4. Create a new Stimulus controller ( PostReplaceController for this example ). The channel will then be connected to it in the connect method and disconnect method.
5. Update the View to to connect to the controller ( show.html.erb for this example )
6. Introduce the hook for the job which can be reduced to a simple wrapper to call logic in the model ( Post ). The model is then able to transmit to the data. The `received` execution will then change the reference HTML to the content from the method. This content in this context is a stream of pre-formatted HTML.
