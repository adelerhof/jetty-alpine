package nl.vijfhart;

import java.util.*;
import javax.ws.rs.*;
import javax.ws.rs.core.*;

@Path("java-webapp")
public class MyResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() {
        return "Hello from java-webapp";
    }
}
