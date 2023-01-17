import logo from "./logo.svg";
import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";

const AppPage = () => {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
};

const TestPage = () => {
  return <>TEST PAGE</>;
};

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route exact path="/" element={AppPage()} />
        <Route path="/test" element={TestPage()} />
      </Routes>
    </BrowserRouter>
  );
}
export default App;
