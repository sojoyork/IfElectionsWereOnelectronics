<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IfEletionsWereOnEletronics.com</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff8dc;
        }
        header {
            background-color: #ff6347;
            color: #fff;
            padding: 1rem 0;
            text-align: center;
        }
        nav {
            background-color: #ffa07a;
            text-align: center;
            padding: 0.5rem 0;
        }
        nav a {
            color: #fff;
            margin: 0 1rem;
            text-decoration: none;
            font-weight: bold;
        }
        main {
            padding: 2rem;
            text-align: center;
        }
        section {
            margin-bottom: 2rem;
        }
        footer {
            background-color: #ff6347;
            color: #fff;
            text-align: center;
            padding: 1rem 0;
            position: relative;
            width: 100%;
        }
        .joke {
            font-size: 1.2rem;
            color: #ff4500;
        }
        .form-container {
            margin: 2rem auto;
            padding: 1rem;
            background-color: #f0e68c;
            border: 2px solid #ff4500;
            width: 300px;
            text-align: left;
        }
        .form-container input, .form-container button {
            width: 100%;
            padding: 0.5rem;
            margin: 0.5rem 0;
        }
        .ticket {
            margin: 2rem auto;
            padding: 1rem;
            background-color: #f0e68c;
            border: 2px solid #ff4500;
            width: 300px;
            text-align: center;
            display: none;
            cursor: grab;
        }
        .dropzone {
            margin: 2rem auto;
            padding: 2rem;
            background-color: #ffe4b5;
            border: 2px dashed #ff4500;
            width: 300px;
            text-align: center;
            display: none;
        }
        .dropzone.hover {
            background-color: #ffdead;
        }
    </style>
    <script>
        function generateTicket(event) {
            event.preventDefault();
            const candidate = document.getElementById('candidate').value;
            if (candidate) {
                document.getElementById('ticket-candidate').innerText = candidate;
                document.getElementById('ticket').style.display = 'block';
                document.getElementById('dropzone').style.display = 'block';
            }
        }

        function allowDrop(event) {
            event.preventDefault();
        }

        function drag(event) {
            event.dataTransfer.setData("text", event.target.id);
        }

        function drop(event) {
            event.preventDefault();
            const data = event.dataTransfer.getData("text");
            const ticket = document.getElementById(data);
            event.target.appendChild(ticket);
            alert("You have confirmed your election!");
            ticket.style.cursor = 'default';
            ticket.setAttribute("draggable", "false");
            event.target.classList.remove('hover');
        }

        function dragEnter(event) {
            event.preventDefault();
            event.target.classList.add('hover');
        }

        function dragLeave(event) {
            event.preventDefault();
            event.target.classList.remove('hover');
        }

        function observeIntersections() {
            const ticket = document.getElementById('ticket');
            const dropzone = document.getElementById('dropzone');

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        alert("Thanks for voting! (sometimes this pops up even if the ticket is not touching the election box)");
                        observer.unobserve(dropzone); // Stop observing after the first alert
                    }
                });
            }, { threshold: 0.5 });

            observer.observe(dropzone);
        }

        document.addEventListener('DOMContentLoaded', () => {
            observeIntersections();
        });
    </script>
</head>
<body>

    <header>
        <h1>IfEletionsWereOnEletronics.com</h1>
    </header>

    <nav>
        <a href="#home">Home</a>
        <a href="#about">About</a>
        <a href="#services">Services</a>
        <a href="#contact">Contact</a>
    </nav>

    <main>
        <h2>Welcome to IfEletionsWereOnEletronics.com</h2>
        <p class="joke">The most electrifying place for non-existent elections!</p>
        <section id="home">
            <h3>Home</h3>
            <p>Imagine a world where elections happen with just a push of a button. No, really, just imagine it, because it's not happening here!</p>
        </section>
        <section id="about">
            <h3>About</h3>
            <p>We are dedicated to the concept of electronic elections that are so advanced, they don't even exist yet!</p>
        </section>
        <section id="services">
            <h3>Services</h3>
            <p>Offering a wide range of services from imaginary vote counting to fictitious candidate debates.</p>
        </section>
        <section id="contact">
            <h3>Contact</h3>
            <p>Want to reach out? Just send a message to nowhere@noemail.com, and we'll get back to you in your dreams!</p>
        </section>
        <section id="form">
            <h3>Election Form</h3>
            <div class="form-container">
                <form onsubmit="generateTicket(event)">
                    <label for="candidate">Candidate Name:</label>
                    <input type="text" id="candidate" name="candidate" required>
                    <button type="submit">Submit</button>
                </form>
            </div>
        </section>
        <section id="ticket" class="ticket" draggable="true" ondragstart="drag(event)">
            <h3>Election Ticket</h3>
            <p>You have elected: <span id="ticket-candidate"></span></p>
        </section>
        <section id="dropzone" class="dropzone" ondrop="drop(event)" ondragover="allowDrop(event)" ondragenter="dragEnter(event)" ondragleave="dragLeave(event)">
            <p>Drag your election ticket here to confirm!</p>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 IfEletionsWereOnEletronics.com. All jokes reserved.</p>
    </footer>

</body>
</html>
