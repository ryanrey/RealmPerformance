//
//  RealmContext.swift
//
//  Copyright © 2019 Ark. All rights reserved.

import Foundation
import RealmSwift

extension RealmContext {
    public enum PersistenceType {
        case inMemory
        case onDisk
    }
}

extension RealmContext {
    fileprivate struct Constant {
        static let latestSchemaVersion: UInt64 = 4
    }
}

public class RealmContext {
    static let shared = RealmContext()
    
    private let persistenceType: PersistenceType
    
    init(persistenceType: PersistenceType = .onDisk) {
        self.persistenceType = persistenceType
    }
    
    public func setup() {
        switch persistenceType {
        case .inMemory: setupInMemoryConfiguration()
        case .onDisk: setupOnDiskConfiguration()
        }
    }
    
    private func setupInMemoryConfiguration() {
        var config = Realm.Configuration(inMemoryIdentifier: "InMemConfiguration", shouldCompactOnLaunch: { totalBytes, usedBytes in
            let twentyMB = 20 * 1024 * 1024
            return (totalBytes > twentyMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
        })
        
        config.deleteRealmIfMigrationNeeded = true
        config.schemaVersion = Constant.latestSchemaVersion
        config.migrationBlock = handleRealmMigration
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    private func setupOnDiskConfiguration() {
        var config = Realm.Configuration(shouldCompactOnLaunch: { totalBytes, usedBytes in
            let twentyMB = 20 * 1024 * 1024
            return (totalBytes > twentyMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
        })
        
        config.deleteRealmIfMigrationNeeded = true
        
        let newURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("com.ark.performanceTests.realm")
        
        config.fileURL = newURL
        config.schemaVersion = Constant.latestSchemaVersion
        config.migrationBlock = handleRealmMigration
    }
    
    private func handleRealmMigration(migration: Migration, oldSchemaVersion: UInt64) {
        if oldSchemaVersion < Constant.latestSchemaVersion { }
    }
}
