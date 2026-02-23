import load_mujoco from 'mujoco_wasm/mujoco_wasm.js'

/** @typedef {import('mujoco_wasm').MainModule} Mujoco */
/** @typedef {import('mujoco_wasm').MjSpec} Spec */

/** @type {() => Promise<Mujoco>} */
export const loadMujoco_ = () => load_mujoco()

/** @type {(mj: Mujoco) => (xml: String) => () => Spec} */
export const parseXMLString = m => xml => () => m.parseXMLString(xml)
