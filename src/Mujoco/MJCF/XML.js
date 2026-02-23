import ReactDOM from 'react-dom/server.js'

/** @type {(node: import('react').ReactElement) => String} */
export const renderToString = el => ReactDOM.renderToStaticMarkup(el)
