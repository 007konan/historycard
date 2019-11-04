//
//  ViewController.swift
//  historycard
//
//  Created by 藤田一貴 on 2019/10/27.
//  Copyright © 2019 kazuki fujita. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var saveExperienceButton: UIButton!
    @IBOutlet weak var loadExperienceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Set the scene to the view
        sceneView.scene = SCNScene()
        
        //coachingUIを使用
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = sceneView.session
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.goal = .tracking
        sceneView.addSubview(coachingOverlay)
        
        //画面の中心に表示させる為に入れています。
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
        
        //特徴点
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    //arworldmap保存
    @IBAction func saveExperience(_ button: UIButton) {
        sceneView.session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap
                else { return }
            
            // Add a snapshot image indicating where themap was captured.
//            guard let snapshotAnchor = SnapshotAnchor(capturing: self.sceneView)
//                else { fatalError("Can't take snapshot") }
//            map.anchors.append(snapshotAnchor)
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                try data.write(to: self.mapSaveURL, options: [.atomic])
                DispatchQueue.main.async {
                    self.loadExperienceButton.isHidden = false
                    self.loadExperienceButton.isEnabled = true
                }
            } catch {
                fatalError("Can't save map: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Called opportunistically to verify that map data can be loaded from filesystem.
    var mapDataFromFile: Data? {
        return try? Data(contentsOf: mapSaveURL)
    }
    
    //ARWorldMapの復元
    @IBAction func loadExperience(_ button: UIButton) {
        
        /// - Tag: ReadWorldMap
        let worldMap: ARWorldMap = {
            guard let data = mapDataFromFile
                else { fatalError("Map data should already be verified to exist before Load button is enabled.") }
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)
                    else { fatalError("No ARWorldMap in archive.") }
                return worldMap
            } catch {
                fatalError("Can't unarchive ARWorldMap from file data: \(error)")
            }
        }()
        
        // Display the snapshot image stored in the world map to aid user in relocalizing.
//        if let snapshotData = worldMap.snapshotAnchor?.imageData,
//            let snapshot = UIImage(data: snapshotData) {
//            self.snapshotThumbnail.image = snapshot
//        } else {
//            print("No snapshot image in world map")
//        }
//        // Remove the snapshot anchor from the world map since we do not need it in the scene.
//        worldMap.anchors.removeAll(where: { $0 is SnapshotAnchor })
        
        let configuration = self.defaultConfiguration // this app's standard world tracking settings
        configuration.initialWorldMap = worldMap
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        isRelocalizingMap = true
        virtualObjectAnchor = nil
    }
    
    var isRelocalizingMap = false
    var virtualObjectAnchor: ARAnchor?
    
    var defaultConfiguration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        return configuration
    }
    
    lazy var mapSaveURL: URL = {
        do {
            return try FileManager.default
                .url(for: .documentDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent("map.arexperience")
        } catch {
            fatalError("Can't get file save URL: \(error.localizedDescription)")
        }
    }()
    
    //restartボタン
    @IBAction func resetTracking(_ sender: UIButton?) {
        sceneView.session.run(defaultConfiguration, options: [.resetTracking, .removeExistingAnchors])
        isRelocalizingMap = false
        virtualObjectAnchor = nil
    }

}
